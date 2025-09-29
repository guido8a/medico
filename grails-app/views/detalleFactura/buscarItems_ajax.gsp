
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

<div class="row" style="margin-bottom: 20px">
    <div class="col-md-1">
        <label>Código:</label>
    </div>
    <div class="col-md-2">
        <g:textField name="codigoItem_name" id="codigoBuscar" class="form-control validarNumDec"/>
    </div>
    <div class="col-md-1">
        <label>Nombre:</label>
    </div>
    <div class="col-md-4">
        <g:textField name="nombreItem_name" id="nombreBuscar" class="form-control"/>
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-info" id="btnBuscarItem"><i class="fa fa-search"></i> Buscar item</a>
    </div>
</div>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 15%">Código</th>
        <th style="width: 50%">Nombre</th>
        <th style="width: 15%">Precio</th>
        <th style="width: 10%">Existencias</th>
        <th style="width: 10%"><i class="fa fa-check"></i> </th>
    </tr>
    </thead>
</table>

<div id="divTablaItems">
</div>

<script type="text/javascript">

    function validarNumDec(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
    }

    $(".validarNumDec").keydown(function (ev) {
        return validarNumDec(ev);
    }).keyup(function () {
    });


    $("#btnBuscarItem").click(function () {
        cargarTablaItems();
    });

    cargarTablaItems();

    function cargarTablaItems () {
        var codigo = $("#codigoBuscar").val();
        var nombre = $("#nombreBuscar").val();
        openLoader("Buscando");
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'detalleFactura', action: 'tablaItems_ajax')}',
            data:{
                proceso: '${proceso?.id}',
                codigo: codigo,
                nombre: nombre,
                bodega: '${bodega?.id}'
            },
            success: function (msg) {
                closeLoader();
                $("#divTablaItems").html(msg)
            }
        })
    }

    $("#codigoBuscar, #nombreBuscar").keyup(function (ev) {
        if (ev.keyCode == 13) {
            cargarTablaItems();
        }
    });

</script>