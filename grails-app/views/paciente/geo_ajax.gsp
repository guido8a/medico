<fieldset class="borde">
    <div class="col-md-10">
        <div class="col-md-2" style="width: 90px">Buscar Por</div>
        <div class="col-md-2"><g:select name="buscarPor-geo" class="buscarPor"
                                        from="['1': 'Provincia', '2': 'Cantón', '3': 'Parroquia']"
                                        style="width: 100px; margin-left: -20px" optionKey="key"
                                        optionValue="value"/></div>
        <div class="col-md-2">Criterio</div>
        <div class="col-md-2" style="margin-left: -50px"><g:textField name="criterio-geo" class="criterio" style="width: 80px"/></div>
        <div class="col-md-2">Ordenar</div>
        <div class="col-md-2"><g:select name="ordenar-geo" class="ordenar" from="['1': 'Ascendente', '2': 'Descendente']"
                                        style="width: 120px; margin-left: -40px;" optionKey="key"
                                        optionValue="value"/></div>
    </div>

    <div class="col-md-2" style="margin-left: -10px">
        <button class="btn btn-info" id="btn-consultar-geo"><i
                class="fa fa-search"></i> Buscar
        </button>
    </div>

</fieldset>

<fieldset class="borde">
    <div id="divTabla" style="height: 360px; overflow-y:auto; overflow-x: auto;">
    </div>
</fieldset>

<script type="text/javascript">

$("#btn-consultar-geo").click(function () {
    var buscarPor = $("#buscarPor-geo").val();
    var criterio = $("#criterio-geo").val();
    var ordenar = $("#ordenar-geo").val();
    $.ajax({
        type: "POST",
        url: "${createLink(action:'situacionGeografica')}",
            data: {
                buscarPor: buscarPor,
                criterio: criterio,
                ordenar: ordenar
            },
            success: function (msg) {
                $("#divTabla").html(msg);
                $("#dlgLoad").dialog("close");
            }
        });
    })

</script>