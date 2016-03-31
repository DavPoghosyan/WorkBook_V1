package workbook



class SelectCompany {
    static namespace = 'local'


    /**
     * Renders a locale selector.
     * Adds the class <code>active</code> to the list-element of the current language.
     */


    def empLink = {attrs ->
        def emp = attrs.employee
        def empName = "${emp?.firstName}"

        if (emp?.active){
            out << link(controller:'employee', action:'detail',
                    id:emp.id){empName}
        } else {
            out << empName
        }
    }
}