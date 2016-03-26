package am.webbfontaine.training.rimm

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
