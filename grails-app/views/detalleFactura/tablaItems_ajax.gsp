


<div class="row">
    <div class="col-md-12" style="width: 99.7%;height: 200px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table table-bordered table-hover table-condensed" style="width: 100%">
            <tbody>
            <g:each in="${items}" var="item">
                <tr style="width: 100%">
                    <td style="width: 15%">${item.prodnmro}</td>
                    <td style="width: 50%">${item.prodtxto}</td>
                    <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'V' || proceso?.tipoProceso?.codigo?.trim() == 'NC'}">
                        <td style="width: 15%; text-align: right">${item.prodpcun}</td>
                    </g:if>
                    <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C' || proceso?.tipoProceso?.codigo?.trim() == 'T'}">
                        <td style="width: 15%; text-align: right">${item.prodpccs}</td>
                    </g:if>
                    <td style="width: 10%; text-align: center">${item.exst.toInteger()}</td>
                %{--                    <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'C'}">--}%
                %{--                        <td style="width: 10%; text-align: center">--}%
                %{--                            <a href="#" class="btn btn-success btnAgregarItem"--}%
                %{--                               title="Agregar Item" codigo="${item.prodnmro}" nombre="${item.prodtxto}" precio="${item.prodpcun}" exis="${item.exst}"  idI="${item.prod__id}" costo="${item.prodpccs}">--}%
                %{--                                <i class="fa fa-check"></i></a>--}%
                %{--                        </td>--}%
                %{--                    </g:if>--}%
                %{--                    <g:else>--}%
                    <g:if test="${item.exst.toInteger() > 0}">
                        <td style="width: 10%; text-align: center">
                            <a href="#" class="btn btn-success btn-xs btnAgregarItem"
                               title="Agregar Item" codigo="${item.prodnmro}" nombre="${item.prodtxto}" precio="${item.prodpcun}" exis="${item.exst}"  idI="${item.prod__id}" costo="${item.prodpccs}">
                                <i class="fa fa-check"></i></a>
                        </td>
                    </g:if>
                    <g:else>
                        <td style="width: 10%; text-align: center">
                        </td>
                    </g:else>
                %{--                    </g:else>--}%
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">

    $(".btnAgregarItem").click(function () {
        var codigo = $(this).attr('codigo');
        var nombre = $(this).attr('nombre');
        var precio = $(this).attr('precio');
        var precioCosto = $(this).attr('costo');
        var idI = $(this).attr('idI');
        var ex = Math.round($(this).attr('exis')*100)/100;
        $("#codigoItem").val(codigo);
        $("#nombreItem").val(nombre);
        <g:if test="${proceso?.tipoProceso?.codigo?.trim() == 'T'}">
        $("#precioItem").val(precioCosto);
        </g:if>
        <g:else>
        $("#precioItem").val(precio);
        </g:else>
        $("#idItem").val(idI);
//        $("#cantidadItem").val(ex);
        $("#cantidadItem").val(1);
        $("#descuentoItem").val(0);
        $("#totalItem").val(precio);
        $("#cantiOriginal").val(ex);
        bootbox.hideAll();
    });

</script>