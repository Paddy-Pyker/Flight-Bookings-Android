#include "command-controller.h"
#include <QList>
#include <QDebug>

using namespace cm::framework;
using namespace cm::models;
using namespace cm::networking;

namespace cm {
namespace controllers {

class CommandController::Implementation
{
public:
    Implementation(CommandController* _commandController, IDatabaseController* _databaseController, INavigationController* _navigationController, Client* _newClient, ClientSearch* _clientSearch, IWebRequest* _rssWebRequest)
        : commandController(_commandController)
        , databaseController(_databaseController)
        , navigationController(_navigationController)
        , newClient(_newClient)
        , clientSearch(_clientSearch)
        , rssWebRequest(_rssWebRequest)
    {
        Command* viewPlanesCommand = new Command(commandController, QChar( 0xf072 ), "Planes");
        QObject::connect( viewPlanesCommand, &Command::executed, commandController, &CommandController::onCreateClientPlaneExecuted );
        createClientViewContextCommands.append( viewPlanesCommand );

        Command* createClientSaveCommand = new Command( commandController, QChar( 0xf0c7 ), "Save" );
        QObject::connect( createClientSaveCommand, &Command::executed, commandController, &CommandController::onCreateClientSaveExecuted );
        createClientViewContextCommands.append( createClientSaveCommand );


        Command* findClientViewClientsCommand = new Command( commandController, QChar( 0xf2ba ), "Passengers " );
        QObject::connect( findClientViewClientsCommand, &Command::executed, commandController, &CommandController::onFindClientViewClientsExecuted );
        findClientViewContextCommands.append( findClientViewClientsCommand );

        Command* findClientSearchCommand = new Command( commandController, QChar( 0xf002 ), "Search" );
        QObject::connect( findClientSearchCommand, &Command::executed, commandController, &CommandController::onFindClientSearchExecuted );
        findClientViewContextCommands.append( findClientSearchCommand );



        Command* editClientDeleteCommand = new Command( commandController, QChar( 0xf235 ), "Delete" );
        QObject::connect( editClientDeleteCommand, &Command::executed, commandController, &CommandController::onEditClientDeleteExecuted );
        editClientViewContextCommands.append( editClientDeleteCommand );

        Command* editClientSaveCommand = new Command( commandController, QChar( 0xf0c7 ), "Save" );
        QObject::connect( editClientSaveCommand, &Command::executed, commandController, &CommandController::onEditClientSaveExecuted );
        editClientViewContextCommands.append( editClientSaveCommand );

        Command* rssRefreshCommand = new Command( commandController, QChar( 0xf021 ), "Refresh" );
        QObject::connect( rssRefreshCommand , &Command::executed, commandController, &CommandController::onRssRefreshExecuted );
        rssViewContextCommands.append( rssRefreshCommand  );


        rssWebRequest->execute();

    }

    CommandController* commandController{nullptr};

    IDatabaseController* databaseController{nullptr};
    INavigationController* navigationController{nullptr};
    Client* newClient{nullptr};
    ClientSearch* clientSearch{nullptr};
    Client* selectedClient{nullptr};
    IWebRequest* rssWebRequest{nullptr};
    QList<Command*> createClientViewContextCommands{};
    QList<Command*> findClientViewContextCommands{};
    QList<Command*> editClientViewContextCommands{};
    QList<Command*> rssViewContextCommands{};
};

CommandController::CommandController(QObject* parent, IDatabaseController* databaseController, INavigationController* navigationController, Client* newClient, ClientSearch* clientSearch, IWebRequest* rssWebRequest)
    : ICommandController(parent)
{
    implementation.reset(new Implementation(this, databaseController, navigationController, newClient, clientSearch, rssWebRequest));
}

CommandController::~CommandController()
{
}

QQmlListProperty<Command> CommandController::ui_createClientViewContextCommands()
{
    return QQmlListProperty<Command>(this, implementation->createClientViewContextCommands);
}

QQmlListProperty<Command> CommandController::ui_findClientViewContextCommands()
{
    return QQmlListProperty<Command>(this, implementation->findClientViewContextCommands);
}

QQmlListProperty<Command> CommandController::ui_editClientViewContextCommands()
{
    return QQmlListProperty<Command>(this, implementation->editClientViewContextCommands);
}

QQmlListProperty<framework::Command> CommandController::ui_rssViewContextCommands()
{
    return QQmlListProperty<Command>(this, implementation->rssViewContextCommands);
}

void CommandController::setSelectedClient(Client* client)
{
    implementation->selectedClient = client;
}



void CommandController::onCreateClientPlaneExecuted()
{
    emit viewPlanesExecuted();
}


void CommandController::onCreateClientSaveExecuted()
{


    if(implementation->newClient->validate()) {

        emit fillAll(); // Check if plane is seat is selected

    }  else  if(implementation->newClient->validateLocation()) {

        emit checkLocation();  //Check if Locations are the same

    }  else {

        if (implementation->databaseController->createRow(implementation->newClient->key(),implementation->newClient->reference->value(), implementation->newClient->id(), implementation->newClient->toJson()))
        {
            implementation->databaseController->addSeat(implementation->newClient->planeId->value(),implementation->newClient->seatNumber->value());
            implementation->clientSearch->searchText()->setValue(implementation->newClient->id());
            implementation->clientSearch->search();

            if(implementation->newClient->clearDecorators())
                implementation->navigationController->goFindClientView();


        }

    }

}

void CommandController::onFindClientSearchExecuted()
{
    qDebug() << "You executed the Search command!";

    implementation->clientSearch->search();

}

void CommandController::onFindClientViewClientsExecuted()
{
    qDebug() <<"You tried viewing all Clients!";
    implementation->clientSearch->view();
}

void CommandController::onEditClientSaveExecuted()
{
    qDebug() << "You executed the Save command!";

    implementation->databaseController->updateRow(implementation->selectedClient->key(), implementation->selectedClient->id(), implementation->selectedClient->toJson());

    qDebug() << "Updated client saved.";
    implementation->navigationController->goFindClientView();
}

void CommandController::onEditClientDeleteExecuted()
{
    qDebug() << "You executed the Delete command!";

    if (implementation->databaseController->deleteRow(implementation->selectedClient->key(), implementation->selectedClient->id()))

    {
        implementation->databaseController->delSeat(implementation->selectedClient->planeId->value(),implementation->selectedClient->seatNumber->value());
        implementation->selectedClient = nullptr;
        implementation->clientSearch->search();
        implementation->navigationController->goDashboardView();
    }






}

void CommandController::onRssRefreshExecuted()
{
    qDebug() << "You executed the RSS Refresh command!";

    implementation->rssWebRequest->execute();
}

}}
