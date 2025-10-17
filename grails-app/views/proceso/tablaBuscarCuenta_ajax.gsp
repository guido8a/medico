<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${cuentas}" var="cuenta">
        <tr>
            <td style="width: 15%">${cuenta.numero}</td>
            <td style="width: 55%">${cuenta.descripcion}</td>
            <td style="width: 14%">${cuenta.nivel.descripcion}</td>
            <td style="width: 15%; text-align: center">
                <a href="#" class="btn btn-success btnAgregarCuenta" cuenta="${cuenta.id}" codigo="${cuenta.numero}" nombre="${cuenta.descripcion}" title="Agregar cuenta ">
                    <i class="fa fa-plus"></i>
                    Agregar
                </a>
            </td>
            <td style="width: 1%"></td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".btnAgregarCuenta").click(function () {
        var cuenta = $(this).attr('cuenta');
        var codigo = $(this).attr('codigo');
        var nombre = $(this).attr('nombre');

        $("#codigoAsiento").val(codigo);
        $("#nombreAsiento").val(nombre);
        $("#cuenta").val(cuenta);

        cerrarBuscarCuenta();
    });
</script>