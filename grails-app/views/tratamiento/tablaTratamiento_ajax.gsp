<g:if test="${tratamientos.size() > 0}">
    <div id="list-DocumentoProceso" role="main">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr style="width: 100%">
                <th style="width: 10%">Medicina </th>
                <th style="width: 10%">Concentración </th>
                <th style="width: 10%">Cantidad </th>
                <th style="width: 25%">Prescripción</th>
                <th style="width:10%">Acciones</th>
            </tr>
            </thead>
            <tbody >

            <g:each in="${tratamientos}" status="i" var="tratamiento">
                <tr style="width: 100%">
                    <td style="width: 25%">${tratamiento?.medicina?.codigo ? (tratamiento?.medicina?.codigo  + " - " + tratamiento?.medicina?.descripcion) : ''}</td>
                    <td style="width: 10%">${tratamiento?.medicina?.concentracion}</td>
                    <td style="width: 8%">${tratamiento?.cantidad}</td>
                    <td style="width: 47%">${tratamiento?.descripcion}</td>
                    <td style="width:10%">
                        <a class="btn btn-success btn-xs btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${tratamiento.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-danger btn-xs btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${tratamiento.id}">
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
    <div class="alert alert-warning"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> La cita no contiene tratamientos</div>
</g:else>

<script type="text/javascript">

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    }); //click btn edit

    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id)
    });

</script>