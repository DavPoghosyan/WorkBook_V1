package com.webbfontaine.training

class Company {

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
