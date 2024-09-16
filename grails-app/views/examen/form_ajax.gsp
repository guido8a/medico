
<g:if test="${!examen}">
    Error
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmExamen" role="form" action="save" method="POST" useToken="true">
        <g:hiddenField name="id" value="${examen?.id}" />

        <div class="form-group ${hasErrors(bean: examen, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="grupo" class="col-md-2 control-label text-info">
                    Grupo
                </label>
                <span class="col-md-8">
                    <g:select name="grupo" from="${medico.GrupoExamen.list([sort: 'descripcion'])}" class="form-control" optionKey="id" optionValue="descripcion" />
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Tipo
                </label>
                <span class="col-md-8" id="divTipoExamen">

                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <span class="col-md-8">
                    <g:textArea name="descripcion" maxlength="255" class="form-control required" value="${examen?.descripcion}" style="height: 75px; resize: none"/>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'numero', 'error')} ">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Número
                </label>
                <span class="col-md-3">
                    <g:textField name="numero" maxlength="4" class="form-control" value="${examen?.numero}"/>
                </span>
            </span>
        </div>
    </g:form>

    <script type="text/javascript">

        cargarTipoExamen();

        $("#grupo").change(function () {
            cargarTipoExamen();
        });

        function cargarTipoExamen(){
            var d = cargarLoader("Cargando...");
            var grupo = $("#grupo option:selected").val();
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'examen', action: 'tipo_ajax')}',
                data:{
                    id: grupo
                },
                success: function (msg){
                    d.modal("hide");
                    $("#divTipoExamen").html(msg)
                }
            })
        }

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