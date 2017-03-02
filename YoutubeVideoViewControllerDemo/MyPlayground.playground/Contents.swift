//: Playground - noun: a place where people can play

import UIKit

struct Car {}
struct Place {
    var name: String
}

func driveByCar(car: Car) {}

var aCar = Car()

func drive(byCar car: Car, fromPlace place: Place = Place(name: "My Home")) {
    car
}

drive(byCar: aCar)
drive(byCar: aCar, fromPlace: Place(name: "Office"))