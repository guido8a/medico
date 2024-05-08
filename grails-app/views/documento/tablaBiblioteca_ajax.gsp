<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 20%">Palabra Clave</th>
            <th style="width: 45%">Descripción</th>
            <th style="width: 20%">Documento</th>
            <th style="width: 15%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos.size() > 0}">
            <g:each in="${datos}" status="i" var="documento">
                <tr>
                    <td style="width: 20%">${documento.dcmtclve}</td>
                    <td style="width: 45%">${documento.dcmtdscr}</td>
                    <td style="width: 20%">
                        <g:if test="${documento.dcmtruta}">
                            <strong style="font-size: 14px"> ${documento.dcmtruta} </strong>
                        </g:if>
                        <g:else>
                            <i class="fa fa-exclamation-triangle fa-2x text-info"></i> <strong>No tiene documentos adjuntos</strong>
                        </g:else>
                    </td>
                    <td style="width: 15%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnEditarDocumento" data-id="${documento.dcmt__id}" title="Editar documento">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a class="btn btn-info btn-xs btnCargarDocumento" href="#" rel="tooltip" title="Subir documento" data-id="${documento.dcmt__id}">
                            <i class="fa fa-upload"></i>
                        </a>
                        <g:if test="${documento.dcmtruta}">
                            <g:if test="${documento?.dcmtruta?.toString()?.split("\\.")[1] == 'pdf'}">
                                <g:link class="btn btn-warning btn-xs"
                                        action="downloadMyFile" resource="${instance}"
                                        target="_blank" title="Ver PDF"><i class="fa fa-search"></i>
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link action="downloadFile" class="btn btn-warning btn-xs btn-docs" rel="tooltip" title="Descargar" id="${documento.dcmt__id}">
                                    <i class="fa fa-download"></i>
                                </g:link>
                            </g:else>
                        </g:if>
                        <a href="#" class="btn btn-xs btn-danger btnEliminarDocumento" data-id="${documento.dcmt__id}" title="Eliminar documento">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> El consultorio no contiene documentos</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    var cd;

    $(".btnEditarDocumento").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarDocumento").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

    $(".btnCargarDocumento").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'documento', action:'formCargarDocumento_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                cd = bootbox.dialog({
                    id      : "dlgDoc",
                    title   : "Documento",
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

    function cerrarCD(){
        cd.modal("hide");
    }

</script>