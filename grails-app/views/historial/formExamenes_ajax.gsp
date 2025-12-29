<%@ page import="medico.Examen" %>

<div class="span" role="main">
    <g:uploadForm class="form-horizontal" method="post" name="frmExamen" action="saveExamen_ajax">
        <g:hiddenField name="id" value="${examen?.id}"/>
        <g:hiddenField name="historial" value="${historial.id}"/>

        <div class="form-group ${hasErrors(bean: examen, field: 'fecha', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <span class="col-md-4">
                    <input aria-label="" name="fechaExamen" id='fechaExamen' type='text' class="form-control" value="${examen?.fecha?.format("dd-MM-yyyy") ?: new Date()?.format("dd-MM-yyyy")}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <g:if test="${!examen?.id}">
            <div class="form-group">
                <span class="grupo">
                    <label class="col-md-2 control-label text-info">
                        Buscar
                    </label>
                    <span class="col-md-4">
                        <g:textField name="buscar" id="textoExamenBuscar" type="search" class="form-control" />
                    </span>
                    <span class="col-md-2">
                        <a href="#" id="btnBusquedaExamen" class="btn btn-info" title="Buscar">
                            <i  class="fa fa-search"></i>
                        </a>
                        <a href="#" id="btnLimpiarBusquedaExamen" title="Limpiar Búsqueda" class="btn btn-warning">
                            <i  class="fa fa-eraser"></i>
                        </a>
                    </span>
                </span>
            </div>
        </g:if>

        <div class="form-group" id="divExamen">

        </div>

        <g:if test="${tipo == '1'}">
            <div class="form-group ${hasErrors(bean: examen, field: 'datosClinicos', 'error')} ">
                <span class="grupo">
                    <label class="col-md-2 control-label text-info">
                        %{--                        Datos clínicos--}%
                        Tipo de examen
                    </label>
                    <span class="col-md-9">
                        <g:textArea name="datosClinicos" maxlength="511" class="form-control" value="${examen?.datosClinicos}"  style="resize: none; height: 60px;" />
                        <p class="help-block ui-helper-hidden"></p>
                    </span>
                </span>
            </div>
        </g:if>

        <div class="form-group ${hasErrors(bean: examen, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    %{--                    Observaciones--}%
                    Datos clínicos
                </label>
                <span class="col-md-9">
                    <g:textArea name="observaciones" maxlength="511" class="form-control" value="${examen?.observaciones}"  style="resize: none; height: 60px;" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>
    </g:uploadForm>
</div>

<script type="text/javascript">

    $("#btnBusquedaExamen").click(function () {
        cargarExamen();
    });

    $("#btnLimpiarBusquedaExamen").click(function () {
        $("#textoExamenBuscar").val('');
        cargarExamen();
    });

    <g:if test="${examen?.id}">
    cargarExamen();
    </g:if>

    function cargarExamen(){
        var examen = '${examen?.id}';
        var texto = $("#textoExamenBuscar").val();
        var ar = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'examen', action: 'examen_ajax')}',
            data:{
                texto: texto,
                examen: examen,
                tipo: '${tipo}'
            },
            success: function (msg){
                ar.modal("hide");
                $("#divExamen").html(msg)
            }
        })
    }

    $('#fechaExamen').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    $("#frmExamen").validate({
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

    $("#textoExamenBuscar").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarExamen();
            return false;
        }
        return true;
    });

</script>
