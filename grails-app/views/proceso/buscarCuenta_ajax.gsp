<style>
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

<div class="row">
    <div class="col-md-12">
        <div class="row" style="margin-bottom: 10px">
            <div class="col-md-1 negrilla">
                Código
            </div>
            <div class="col-md-3">
                <g:textField class="form-control col-md-6  validacionNumeroSinPuntos" name="codigo_name" id="codigoBus"/>
            </div>
            <div class="col-md-1 negrilla">
                Nombre
            </div>
            <div class="col-md-5 negrilla">
                <g:textField class="form-control col-md-7" name="nombre_name" id="nombreBus"/>
                <g:hiddenField name="movimientos" value="1"/>
            </div>
            <div class="col-md-1">
                <a href="#" class="btn btn-azul"  id="buscarM">
                    <i class="fa fa-search"></i>
                    Buscar
                </a>
            </div>
        </div>

        <table class="table table-bordered table-hover table-condensed">
            <thead>
            <tr style="width: 100%">
                <th style="width: 15%">Código</th>
                <th style="width: 55%">Nombre</th>
                <th style="width: 14%">Nivel</th>
                <th style="width: 15%">Acciones</th>
                <th style="width: 1%"></th>
            </tr>
            </thead>
        </table>

        <div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right; margin-top: -20px">
            <div class="span12">
                <div id="divTablaCuentas"></div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    function validarNumSinPuntos(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

    cargarBuscarCuenta();

    $("#buscarM").click(function (){
        cargarBuscarCuenta();
    });

    function cargarBuscarCuenta () {
        var cod = $("#codigoBus").val();
        var nom = $("#nombreBus").val();
        var empresa = ${empresa?.id}
            openLoader("Buscando");
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'proceso', action: 'tablaBuscarCuenta_ajax')}",
            data:{
                codigo: cod,
                nombre: nom,
                empresa: empresa
            },
            success: function (msg){
                closeLoader();
                $("#divTablaCuentas").html(msg)
            }
        });
    }

    $("#codigoBus, #nombreBus").keyup(function (ev) {
        if (ev.keyCode === 13) {
            cargarBuscarCuenta();
        }
    });

</script>