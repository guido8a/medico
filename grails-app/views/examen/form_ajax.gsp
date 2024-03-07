
<g:if test="${!examen}">
    Error
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmExamen" role="form" action="save" method="POST" useToken="true">
        <g:hiddenField name="id" value="${examen?.id}" />

        <div class="form-group ${hasErrors(bean: examen, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <span class="col-md-8">
                    <g:textArea name="descripcion" maxlength="63" class="form-control required" value="${examen?.descripcion}" style="height: 75px; resize: none"/>
                </span>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmExamen").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
            }
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode === 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>