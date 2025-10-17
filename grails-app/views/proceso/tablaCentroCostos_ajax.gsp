<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${centros}" var="centro">
        <tr style="width: 100%">
            <td style="width: 50%">${centro?.centroCosto?.nombre}</td>
            <td style="width: 25%; text-align: right">${tipo == '1' ? centro?.debe : centro?.haber}</td>
            <td style="width: 25%;text-align: center">
                <a href="#" class="btn btn-danger btn-xs borrarCost" data-id="${centro?.id}">
                    <i class="fa fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".borrarCost").click(function () {
        var id = $(this).data('id');
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'borrarCentro_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg === 'ok'){
                    log("Registro borrado correctamente","success");
                    cargarTablaCentros();
                    actualizarValor();
                    cargarComprobanteP('${asiento?.comprobante?.proceso?.id}');
                }else{
                    log("Error al borrar el registro", "error")
                }
            }
        });
    });
</script>
