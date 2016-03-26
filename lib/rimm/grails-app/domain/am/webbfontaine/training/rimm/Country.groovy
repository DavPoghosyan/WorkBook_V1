package am.webbfontaine.training.rimm

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
