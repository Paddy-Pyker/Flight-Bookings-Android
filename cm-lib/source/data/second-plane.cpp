#include "second-plane.h"
#include <QDebug>
#include <algorithm>


using namespace cm::data;


SecondPlane::SecondPlane(QObject* parent,Planes* _parent) : Planes(parent)
{

    description = new CustomStringDecorator(_parent,"Description","Airbus . . .");
    selectedSeat = new CustomStringDecorator(_parent,"Select Seat");


    if (QFile::exists("p2a.dat"))
    {
        QFile file1("p2a.dat");

        file1.open(QFile::ReadOnly);
        QDataStream dataStream1(&file1);
        QVariant variant1;
        dataStream1 >> variant1;
        available = variant1.toStringList();
        file1.close();
    }


    if(QFile::exists("p2r.dat"))
    {
        QFile file2("p2r.dat");

        file2.open(QFile::ReadOnly);
        QDataStream dataStream2(&file2);
        QVariant variant2;
        dataStream2 >> variant2;
        reserved = variant2.toStringList();
        file2.close();

    }

}




SecondPlane::~SecondPlane()
{

}


QStringList SecondPlane::AVAILABLE()
{
    return available;

}

QStringList SecondPlane::RESERVED()
{
    return reserved;
}

bool SecondPlane::checkSA()
{

    for (int i = 0; i < available.size(); ++i)

        if (available.at(i) == selectedSeat->value())

            return true;


    return false;

}


void SecondPlane::removeSA(const QString& value)
{

    for (int i = 0; i < reserved.size(); ++i)

        if (reserved.at(i) == value)
        {

            available << value;
            reserved.removeAt(i);


            QFile file1("p2a.dat");
            file1.open(QFile::WriteOnly);
            QDataStream dataStream1(&file1);
            QVariant variant1(available);
            dataStream1 << variant1;
            file1.close();



            QFile file2("p2r.dat");
            file2.open(QFile::WriteOnly);
            QDataStream dataStream2(&file2);
            QVariant variant2(reserved);
            dataStream2 << variant2;
            file2.close();
        }




}

QString SecondPlane::secondplaneNumber()
{

    return  QString::number(reserved.size());
}



void SecondPlane::addSA(const QString& value)
{

    for (int i = 0; i < available.size(); ++i)

        if (available.at(i) == value)
        {

        reserved << value;
        available.removeAt(i);


        QFile file1("p2a.dat");
        file1.open(QFile::WriteOnly);
        QDataStream dataStream1(&file1);
        QVariant variant1(available);
        dataStream1 << variant1;
        file1.close();



        QFile file2("p2r.dat");
        file2.open(QFile::WriteOnly);
        QDataStream dataStream2(&file2);
        QVariant variant2(reserved);
        dataStream2 << variant2;
        file2.close();
    }



}
