package com.webbfontaine.training



import grails.test.mixin.*
import spock.lang.*

@TestFor(WorkBookController)
@Mock(WorkBook)
class WorkBookControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The list action is executed"
            controller.list()

        then:"The model is correct"
            !model.workBookInstanceList
            model.workBookInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.workBookInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def workBook = new WorkBook()
            workBook.validate()
            controller.save(workBook)

        then:"The create view is rendered again with the correct model"
            model.workBookInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            workBook = new WorkBook(params)

            controller.save(workBook)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/workBook/show/1'
            controller.flash.message != null
            WorkBook.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def workBook = new WorkBook(params)
            controller.show(workBook)

        then:"A model is populated containing the domain instance"
            model.workBookInstance == workBook
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def workBook = new WorkBook(params)
            controller.edit(workBook)

        then:"A model is populated containing the domain instance"
            model.workBookInstance == workBook
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/workBook/list'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def workBook = new WorkBook()
            workBook.validate()
            controller.update(workBook)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.workBookInstance == workBook

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            workBook = new WorkBook(params).save(flush: true)
            controller.update(workBook)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/workBook/show/$workBook.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/workBook/list'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def workBook = new WorkBook(params).save(flush: true)

        then:"It exists"
            WorkBook.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(workBook)

        then:"The instance is deleted"
            WorkBook.count() == 0
            response.redirectedUrl == '/workBook/list'
            flash.message != null
    }
}
