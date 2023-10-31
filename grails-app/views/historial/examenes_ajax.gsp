<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

</head>

<body>

<div class="tituloTree">
    Exámenes del  paciente: <span style="font-weight: bold; font-style: italic; font-size: 12px">${historial?.paciente?.apellido + " " + historial?.paciente?.nombre}</span>
</div>

<g:if test="${flash.message}">
    <div class="row">
        <div class="span12">
            <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
                <a class="close" data-dismiss="alert" href="#">×</a>
                ${flash.message}
            </div>
        </div>
    </div>
</g:if>

<div class="row" style="margin-bottom: 10px">
    <div class="col-md-2 btn-group" role="navigation">
        <a href="#" class="btn btn-success btn-new">
            <i class="fa fa-file"></i>
            Nuevo Examen
        </a>
    </div>
</div>

<g:if test="${examenes.size() > 0}">
    <div id="list-DocumentoProceso" role="main">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr style="width: 100%">
                <th style="width: 10%">Etapa</th>
                <th style="width: 25%">Nombre</th>
                <th style="width: 20%">Descripción</th>
                <th style="width: 15%">Resumen</th>
                <th style="width: 10%">Archivo</th>
                <th style="width: 10%">Tipo de archivo</th>
                <th style="width:10%">Acciones</th>
            </tr>
            </thead>
            <tbody >

            <g:each in="${examenes}" status="i" var="examen">
                <tr style="width: 100%">
                    <td style="width: 10%">${examen?.examen?.descripcion}</td>
                    <td style="width: 25%">${examen?.fecha?.format("dd-MM-yyyy")}</td>
                    <td style="width: 20%">${examen?.observaciones}</td>
                    <td style="width: 10%">
                        <g:set var="p" value="${examen.path.split("\\.")}"/>
                        ${p[p.size() - 1]}
                    </td>
                    <td style="width:10%">
                        <a class="btn btn-success btn-xs btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${examen.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <g:link action="downloadFile" class="btn btn-info btn-xs btn-docs" rel="tooltip" title="Descargar" id="${examen.id}">
                            <i class="fa fa-download"></i>
                        </g:link>
                        <a class="btn btn-danger btn-xs btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${examen.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</g:if>
<g:else>
    <div class="alert alert-warning"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> La cita no contiene exámenes</div>
</g:else>

%{--<div class="modal hide fade" id="modal-DocumentoProceso">--}%
%{--    <div class="modal-header" id="modalHeader">--}%
%{--        <button type="button" class="close darker" data-dismiss="modal">--}%
%{--            <i class="icon-remove-circle"></i>--}%
%{--        </button>--}%

%{--        <h3 id="modalTitle"></h3>--}%
%{--    </div>--}%

%{--    <div class="modal-body" id="modalBody">--}%
%{--    </div>--}%

%{--    <div class="modal-footer" id="modalFooter">--}%
%{--    </div>--}%
%{--</div>--}%

<script type="text/javascript">

    $(function () {

        $(".btn-new").click(function () {
            createEditRow();
        }); //click btn new

        $(".btn-edit").click(function () {
            var id = $(this).data("id");
            createEditRow(id);
        }); //click btn edit

        $(".btn-delete").click(function () {
            var id = $(this).data("id");
            deleteRow(id)
        });

    });

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = {
            cita : "${historial.id}",
            id: id
        };
        $.ajax({
            type    : "POST",
            url: "${createLink(action:'formExamenes_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditExamen",
                    title   : title + " Examen",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                submitFormExamen();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit


    function submitFormExamen() {
        var $form = $("#frmExamen");
        if ($form.valid()) {
            var data = $form.serialize();
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                    }else{
                        if(parts[0] === 'err'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }else{
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            return false;
                        }

                    }
                }
            });
        } else {
            return false;
        }
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p style='font-weight: bold'> Está seguro que desea eliminar este registro? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var v = cargarLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    setTimeout(function () {
                                        location.reload()
                                    }, 800);
                                }else{
                                    log(parts[1],"error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

</script>

</body>
</html>
