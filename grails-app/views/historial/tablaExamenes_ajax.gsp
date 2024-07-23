<g:if test="${examenes.size() > 0}">
    <div id="list-DocumentoProceso" role="main">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr style="width: 100%">
                <th style="width: 9%">Grupo </th>
                <th style="width: 10%">Tipo </th>
                <th style="width: 18%">Examen </th>
                <th style="width: 9%">Fecha </th>
                <th style="width: 15%">Observaciones</th>
                <th style="width: 10%">Documento</th>
                <th style="width:14%">Acciones</th>
            </tr>
            </thead>
            <tbody >

            <g:each in="${examenes}" status="i" var="examen">
                <tr style="width: 100%">
                    <td style="width: 9%">${examen?.tipoExamen?.grupoExamen?.descripcion}</td>
                    <td style="width: 10%">${examen?.tipoExamen?.descripcion}</td>
                    <td style="width: 18%">
                        <ul>
                            <g:each in="${medico.DetalleExamen.findAllByExamenComplementario(examen)}">
                                <li>
                                    ${it?.examen?.descripcion}
                                </li>
                            </g:each>
                        </ul>
                    </td>
                    <td style="width: 9%">${examen?.fecha?.format("dd-MM-yyyy")}</td>
                    <td style="width: 15%">${examen?.observaciones}</td>
                    <td style="width: 10%">
                        <g:if test="${examen?.path}">
                            ${examen?.path}
                        </g:if>
                    </td>
                    <td style="width:14%">
                        <a class="btn btn-success btn-xs btnEditarExamenLaboratorio btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${examen.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-info btn-xs btnCargarDocumento" href="#" rel="tooltip" title="Subir documento" data-id="${examen.id}">
                            <i class="fa fa-upload"></i>
                        </a>
                        <g:if test="${examen?.path}">
                            <g:link action="downloadFile" class="btn btn-warning btn-xs btn-docs" rel="tooltip" title="Descargar" id="${examen.id}">
                                <i class="fa fa-download"></i>
                            </g:link>
                        </g:if>
                        <a class="btn btn-danger btn-xs btnBorrarExamenLaboratorio" href="#" rel="tooltip" title="Eliminar" data-id="${examen.id}">
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

<script type="text/javascript">

    var cd;


    $(".btnEditarExamenLaboratorio").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    }); //click btn edit

    $(".btnBorrarExamenLaboratorio").click(function () {
        var id = $(this).data("id");
        deleteRow(id)
    });

    $(".btnCargarDocumento").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'historial', action:'formDocExamenes_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                cd = bootbox.dialog({
                    id      : "dlgDoc",
                    title   : "Documento del examen",
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