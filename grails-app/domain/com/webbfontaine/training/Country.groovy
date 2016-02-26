package com.webbfontaine.training

class Country {

    String code
    String name

    @Override
    String toString() {
        def strCountry = ''
        this.properties.each {
            strCountry += "${it.key} ${it.value} \n"
        }
        strCountry
    }

}
