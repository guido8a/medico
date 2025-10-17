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
        <div class="col-md-12" style="margin-bottom: 10px">
            <div class="col-md-7">
                <label>Centro de Costos</label>
                <g:select from="${cs}" name="selCentro_name" id="selCentro" class="form-control" optionKey="id" optionValue="nombre"/>
            </div>
            <div class="col-md-4">
                <label>Valor</label>
                <g:textField name="vlorCentro_name" id="vlorCentro" class="form-control number vlor" value="${(valor ? valor : 0)}"/>
            </div>
            <div class="col-md-1" style="margin-top: 25px">
                <a href="#" id="agregarCost" class="btn btn-success ${valor == 0 ? 'hidden' : ''}">
                    <i class="fa fa-plus"></i>
                </a>
            </div>
            <g:hiddenField name="valor" id="valorNuevo" value="${valor}"/>
        </div>

        <table class="table table-bordered table-hover table-condensed">
            <thead>
            <tr style="width: 100%">
                <th style="width: 50%">Centro</th>
                <th style="width: 25%">Valor</th>
                <th style="width: 25%">Acciones</th>
            </tr>
            </thead>
        </table>

        <div class="row-fluid"  style="width: 99.7%;height: 100px;overflow-y: auto;float: right; margin-top: -20px">
            <div class="span12">
                <div id="divTablaCentro"></div>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">

    function validarNum(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
        ev.keyCode === 37 || ev.keyCode === 39 ||
        ev.keyCode === 110 || ev.keyCode === 190);
    }

    $(".vlor").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {

        if($(".vlor").val() === 0){
            $("#agregarCost").addClass('Disabled');
        }else{
            $("#agregarCost").removeClass('Disabled');

        }

        if(parseFloat($(".vlor").val()) > parseFloat($("#valorNuevo").val()) || $(".vlor").val() === ''){
            actualizarValor();
            $("#agregarCost").removeClass('Disabled');
        }

    });

    $("#agregarCost").click(function () {
        var valor = $("#vlorCentro").val();
        var centro = $("#selCentro").val();
        if(valor.split('.').length - 1 > 1){
            bootbox.alert("El número ingresado no es válido!")
        }else{
            $.ajax({
                type: 'POST',
                url:'${createLink(controller: 'proceso', action: 'guardarCentro_ajax')}',
                data:{
                    asiento: '${asiento?.id}',
                    valor: valor,
                    centro: centro,
                    tipo: '${tipo}'
                },
                success: function (msg){
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log("Agregado correctamente","success");
                        cargarTablaCentros();
                        actualizarValor();
                        cargarComprobanteP('${asiento?.comprobante?.proceso?.id}');
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
            return false;
        }
    });

    cargarTablaCentros();

    function cargarTablaCentros () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'tablaCentroCostos_ajax')}',
            data:{
                asiento: '${asiento?.id}',
                tipo: '${tipo}'
            },
            success: function (msg){
                $("#divTablaCentro").html(msg)
            }
        });
    }

    function actualizarValor () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'calcularValor_ajax')}',
            data:{
                asiento: '${asiento?.id}',
                tipo: '${tipo}'
            },
            success: function (msg){
                $("#vlorCentro").val(msg);
                $("#valorNuevo").val(msg);
                if(msg === 0){
                    $("#agregarCost").addClass('hidden')
                }else{
                    $("#agregarCost").removeClass('hidden')
                }
            }
        })
    }


</script>