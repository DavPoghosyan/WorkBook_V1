<g:uploadForm action="uploadXmlFile" method="post"
              enctype="multipart/form-data" target="_parent">
    <input class="upload_btn" type="file" name="flyFile" title=""/>
    <div class="overlay-layer">
        <img src="${resource(dir:'images/icons', file:'file-import-icon.png')}" />
        <p class="importTip">
            <g:message code="import.from.xml"/>
        </p>
    </div>
    <g:submitButton name="import" class="import" value="${message(code: 'import.from.xml')}" hidden="hidden"/>
</g:uploadForm>