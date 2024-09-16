
<g:if test="${!tipo}">
    Error
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmExamen" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipo?.id}" />

        <div class="form-group ${hasErrors(bean: tipo, field: 'grupoExamen', 'error')} ">
            <span class="grupo">
                <label for="grupoExamen" class="col-md-2 control-label text-info">
                    Grupo
                </label>
                <span class="col-md-8">
                    <g:select name="grupoExamen" from="${medico.GrupoExamen.list([sort: 'descripcion'])}" class="form-control" optionKey="id" optionValue="descripcion" />
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipo, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <span class="col-md-8">
                    <g:textField name="descripcion" maxlength="63" minlength="0" class="form-control required" value="${tipo?.descripcion}"/>
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