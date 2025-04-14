
<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 30%;">Problema</th>
            <th style="width: 55%;">Documento</th>
            <th style="width: 15%;">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 350px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${guias}">
            <g:each in="${guias}" var="guia" status="i">
                <tr style="width: 100%;">
                    <td style="width: 30%;">${guia?.base?.problema}</td>
                    <td style="width: 55%;">${guia?.ruta}</td>
                    <td style="width: 15%; text-align: center">
                        <g:link action="downloadFile" class="btn btn-warning btn-xs " rel="tooltip" title="Descargar" id="${guia?.id}">
                            <i class="fa fa-download"></i>
                        </g:link>
                        <a href="#" class="btn btn-xs btn-danger btnEliminarDocumento" data-id="${guia?.id}" title="Eliminar documento">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <tr>
                <td colspan="3" style="text-align: center"><i class="fa fa-exclamation-triangle text-info fa-2x"></i> No existen registros</td>
            </tr>
        </g:else>

        </tbody>
    </table>
</div>

<script type="text/javascript">



    $(".btnEliminarDocumento").click(function () {
        var id = $(this).data("id");
        bootbox.confirm({
            message: "<i class='fa fa-3x fa-exclamation-triangle text-danger'></i> <strong style='font-size: 14px'>  Está seguro que desea borrar el documento? </strong>",
            buttons: {
                confirm: {
                    label: '<i class="fa fa-trash"></i> Borrar',
                    className: 'btn-danger'
                },
                cancel: {
                    label: '<i class="fa fa-times"></i> Cancelar',
                    className: 'btn-primary'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'guia', action: 'borrarDocumento_ajax')}',
                        data:{
                            id: id
                        },
                        success: function (msg) {
                            var parts = msg.split("_");
                            if(parts[0] === 'ok'){
                                log(parts[1],"success");
                                cargarTabla();
                            }else{
                                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                            }
                        }
                    });
                }
            }
        });
    });



</script>
