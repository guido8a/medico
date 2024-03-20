<g:if test="${diagnosticos.size() > 0}">
    <div id="list-DocumentoProceso" role="main" style="margin-top: -20px;">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <tbody >

            <g:each in="${diagnosticos}" status="i" var="diagnostico">
                <tr style="width: 100%">
                    <td style="width: 10%">${diagnostico?.diagnostico?.codigo}</td>
                    <td style="width: 50%">${diagnostico?.diagnostico?.descripcion}</td>
                    <td style="width: 30%">${diagnostico?.descripcion}</td>
                    <td style="width: 10%; text-align: center">
                        <a class="btn btn-danger btn-xs btnBorrarDiagnostico" href="#" rel="tooltip" title="Eliminar" data-id="${diagnostico.id}">
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
    <div class="alert alert-warning" style="margin-top: -20px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> La cita no contiene diagnósticos seleccionados</div>
</g:else>

<script type="text/javascript">


    // $(".btnEditarExamenLaboratorio").click(function () {
    //     var id = $(this).data("id");
    //     createEditRow(id);
    // }); //click btn edit
    //
    $(".btnBorrarDiagnostico").click(function () {
        var id = $(this).data("id");
        deleteRowDiagnostico(id)
    });

    function deleteRowDiagnostico(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<span style='text-align: center; font-size: 14px; font-weight: bold'><i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Está seguro que desea eliminar este diagnóstico?.</span>",
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
                            url     : '${createLink(controller: 'historial', action: 'borrarDiagnostico_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1],"success");
                                    cargarTablaDiagnostico();
                                }else{
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }



</script>