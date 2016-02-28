package com.webbfontaine.training

class Country {

    String code
    String name
    String description

    static constraints = {
        code(unique: true)
    }

	@Override
	String toString() {
		name
	}
}
