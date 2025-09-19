<%@ page import="medico.GrupoSanguineo" %>

<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 7%">Cédula</th>
            <th style="width: 12%">Nombres</th>
            <th style="width: 12%">Apellidos</th>
            <th style="width: 13%">Edad</th>
            <th style="width: 5%">Grupo S.</th>
            <th style="width: 13%">Mail</th>
            <th style="width: 7%">HC Anterior</th>
            <th style="width: 10%">Historial</th>
            <th style="width: 8%">Anteriores</th>
            <th style="width: 6%">Factura</th>
            <th style="width: 6%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos}">
            <g:each in="${datos}" status="i" var="paciente">
                <tr data-id="${paciente.pcnt__id}">
                    <td style="width: 7%">${paciente.pcntcdla}</td>
                    <td style="width: 12%">${paciente.pcntnmbr}</td>
                    <td style="width: 12%">${paciente.pcntapll}</td>
                    <td style="width: 13%">${paciente.edad}</td>
                    <td style="width: 5%">${paciente.grsndscr}</td>
                    <td style="width: 13%">${paciente.pcntmail}</td>
                    <td style="width: 7%; text-align: center">
                        <g:if test="${paciente?.pcntpath}">
                            <g:link action="downloadDocumentoCitasAnteriores" class="btn btn-success btn-xs btnDescargarDocCitasAnteriores" rel="tooltip" title="Descargar" id="${paciente?.pcnt__id}">
                                <i class="fa fa-download"></i>
                            </g:link>
                        </g:if>
                        <g:else>
                            <i class="fas fa-times text-danger fa-2x"></i>
                        </g:else>
                    </td>
                    <td style="width: 10%; text-align: center">
                        <a href="${createLink(controller: 'paciente', action: 'historial', id: paciente?.pcnt__id)}"
                           class="btn btn-xs btn-warning" title="Historial del paciente">
                            <i class="fas fa-book"></i> Historia Clínica
                        </a>
                    </td>
                    <td style="width: 8%; text-align: center">
                        <a href="#" class="btn btn-xs btn-info btnCargarCitasAnteriores" data-id="${paciente?.pcnt__id}"
                           title="Cargar la Historia Clínica anterior del paciente">
                            <i class="fas fa-upload"></i> HC pdf
                        </a>
                    </td>
                    <td style="width: 6%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnFacturas" data-id="${paciente?.pcnt__id}"
                           title="Facturas del paciente">
                            <i class="fa fa-money-bill"></i>
                        </a>
                    </td>
                    <td style="width: 6%; text-align: center">
                        <a href="#" class="btn btn-xs btn-danger btnBorrarPaciente" data-id="${paciente?.pcnt__id}" title="Borrar paciente">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    var cd;

    $(".btnFacturas").click(function () {
        var id = $(this).data("id");
        location.href="${createLink(controller: 'paciente', action: 'facturas')}/" + id
    });

    $(".btnBorrarPaciente").click(function () {
        var id = $(this).data("id");
        borrarPaciente(id);
    });

    function borrarPaciente(id) {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><strong style='font-size: 14px'>" +
                "¿Está seguro que desea borrar el paciente seleccionado?</strong>",
            closeButton: false,
            buttons: {
                cancelar: {
                    label: "Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-trash'></i> Borrar",
                    className: "btn-danger",
                    callback: function () {
                        $.ajax({
                            type: "POST",
                            url: '${createLink(controller: 'paciente', action:'borrarPaciente_ajax')}',
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log(parts[1], "success");
                                    cargarTablaPacientes();
                                } else {
                                    log(parts[1], "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    $(".btnCargarCitasAnteriores").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'paciente', action:'cargarCitasAnteriores_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                cd = bootbox.dialog({
                    id      : "dlgDoc",
                    title   : "Cargar Citas Anteriores",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    function cerrarCCA(){
        cd.modal("hide");
    }


</script>

