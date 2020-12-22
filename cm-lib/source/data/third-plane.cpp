#include "third-plane.h"
#include <QDebug>
#include <algorithm>


using namespace cm::data;


ThirdPlane::ThirdPlane(QObject* parent,Planes* _parent) : Planes(parent)
{

    description = new CustomStringDecorator(_parent,"Description","Mil Mi-8 . . .");
    selectedSeat = new CustomStringDecorator(_parent,"Select Seat");


    if (QFile::exists("p3a.dat"))
    {
        QFile file1("p3a.dat");

        file1.open(QFile::ReadOnly);
        QDataStream dataStream1(&file1);
        QVariant variant1;
        dataStream1 >> variant1;
        available = variant1.toStringList();
        file1.close();
    }


    if(QFile::exists("p3r.dat"))
    {
        QFile file2("p3r.dat");

        file2.open(QFile::ReadOnly);
        QDataStream dataStream2(&file2);
        QVariant variant2;
        dataStream2 >> variant2;
        reserved = variant2.toStringList();
        file2.close();

    }

}




ThirdPlane::~ThirdPlane()
{

}


QStringList ThirdPlane::AVAILABLE()
{
    return available;

}

QStringList ThirdPlane::RESERVED()
{
    return reserved;
}

bool ThirdPlane::checkSA()
{

    for (int i = 0; i < available.size(); ++i)

        if (available.at(i) == selectedSeat->value())

            return true;

    return false;

}


void ThirdPlane::removeSA(const QString& value)
{

    for (int i = 0; i < reserved.size(); ++i)

        if (reserved.at(i) == value)
        {

            available << value;
            reserved.removeAt(i);


            QFile file1("p3a.dat");
            file1.open(QFile::WriteOnly);
            QDataStream dataStream1(&file1);
            QVariant variant1(available);
            dataStream1 << variant1;
            file1.close();



            QFile file2("p3r.dat");
            file2.open(QFile::WriteOnly);
            QDataStream dataStream2(&file2);
            QVariant variant2(reserved);
            dataStream2 << variant2;
            file2.close();
        }




}

QString ThirdPlane::thirdplaneNumber()
{

    return  QString::number(reserved.size());
}




void ThirdPlane::addSA(const QString& value)
{

    for (int i = 0; i < available.size(); ++i)

        if (available.at(i) == value)
        {

        reserved << value;
        available.removeAt(i);


        QFile file1("p3a.dat");
        file1.open(QFile::WriteOnly);
        QDataStream dataStream1(&file1);
        QVariant variant1(available);
        dataStream1 << variant1;
        file1.close();



        QFile file2("p3r.dat");
        file2.open(QFile::WriteOnly);
        QDataStream dataStream2(&file2);
        QVariant variant2(reserved);
        dataStream2 << variant2;
        file2.close();
    }


}
