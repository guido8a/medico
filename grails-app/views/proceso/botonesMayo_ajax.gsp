<div class="btn-toolbar toolbar">
    <div class="btn-group-sm">
        <g:if test="${comprobante.registrado != 'S'}">
            <g:if test="${band}">
                <a href="#" class="btn btnMayorizar btn-success" id="reg_${comprobante?.id}" idComp="${comprobante?.id}" style="margin-bottom: 10px;">
                    <i class="fa fa-plus"></i>
                    Mayorizar
                </a>
            </g:if>
        </g:if>
        <g:else>
            <a href="#" class="btn btn-danger" id="btnDesmayorizar" idComp="${comprobante?.id}" style="margin-bottom: 10px;">
                <i class="fa fa-minus "></i>
                Desmayorizar
            </a>
%{--            <a href="#" class="btn btn-info" id="imprimir" iden="${comprobante?.proceso?.id}" nombre="${comprobante.prefijo + comprobante.numero}" style="margin-bottom: 10px;">--}%
%{--            <a href="#" class="btn btn-info" id="imprimir" iden="${comprobante?.proceso?.id}" nombre="${comprobante.numero}" style="margin-bottom: 10px;">--}%
%{--                <i class="fa fa-print"></i>--}%
%{--                Imprimir--}%
%{--            </a>--}%
        </g:else>
    </div>
</div>

<script type="text/javascript">

    %{--$(".btnRetencion").click(function () {--}%
    %{--    var file = "retencion.pdf";--}%
    %{--    var url = $(this).attr("href");--}%
    %{--    location.href = "${createLink(controller:'pdf',action:'pdfLink')}?filename=" + file + "&url=" + url;--}%
    %{--    return false;--}%
    %{--});--}%

    %{--$("#imprimir").click(function () {--}%
    %{--    var url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + '${comprobante?.proceso?.id}' + "Wempresa=${session.empresa.id}";--}%
    %{--    location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobante.pdf";--}%
    %{--});--}%

    $("#btnDesmayorizar").click(function () {
        var id = $(this).attr("idComp");
        bootbox.dialog({
            title: "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message: "<p style='font-size: 14px; font-weight: bold'> Está seguro de desmayorizar este comprobante? Esta acción modificará los saldos</p>",
            buttons: {
                cancelar: {
                    label: "<i class='fa fa-times'></i> Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-minus-circle'></i> Desmayorizar",
                    className: "btn-danger",
                    callback: function () {
                       var m = cargarLoader("Guardando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'desmayorizar_ajax')}',
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                m.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log("Guardado correctamente", "success");
                                    setTimeout(function () {
                                        location.href="${createLink(controller: 'proceso', action: 'comprobante')}?proceso=" + '${comprobante?.proceso?.id}';
                                        cargarComprobanteP('${comprobante?.proceso?.id}');
                                        cargarAsiento('${comprobante?.id}');
                                        cargarBotones('${comprobante?.id}');
                                    }, 800);
                                } else {
                                    log(parts[1], "error");
                                }
                            }
                        });
                    }
                }
            }
        });
    });

    $(".btnMayorizar").click(function () {
        var id = $(this).attr("idComp");
        bootbox.dialog({
            title: "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message: "<p style='font-size: 14px; font-weight: bold'> Esta seguro de mayorizar este comprobante? Esta acción modificará los saldos</p>",
            buttons: {
                cancelar: {
                    label: "<i class='fa fa-times'></i> Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-plus-circle'></i> Mayorizar",
                    className: "btn-danger",
                    callback: function () {
                        var m = cargarLoader("Guardando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'mayorizar_ajax')}',
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                m.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === 'ok') {
                                    log("Guardado correctamente", "success");
                                    setTimeout(function () {
                                        location.href="${createLink(controller: 'proceso', action: 'comprobante')}?proceso=" + '${comprobante?.proceso?.id}';
                                        cargarComprobanteP('${comprobante?.proceso?.id}');
                                        cargarAsiento('${comprobante?.id}');
                                        cargarBotones('${comprobante?.id}');
                                    }, 800);
                                } else {
                                    log(parts[1], "error");
                                }
                            }
                        });
                    }
                }
            }
        });



        %{--bootbox.confirm("<i class='fa fa-exclamation-circle fa-3x pull-left text-danger text-shadow'>" +--}%
        %{--    "</i> Esta seguro de mayorizar este comprobante? Esta acción modificará los saldos", function (result) {--}%
        %{--    if (result) {--}%
        %{--        openLoader("Mayorizando...");--}%
        %{--        $.ajax({--}%
        %{--            type    : "POST",--}%
        %{--            url     : "${createLink(controller: 'proceso',action: 'mayorizar_ajax')}",--}%
        %{--            data    : "id=" + id,--}%
        %{--            success : function (msg) {--}%
        %{--                var parts = msg.split("_");--}%
        %{--                if(parts[0] === 'ok'){--}%
        %{--                    closeLoader();--}%
        %{--                    log(parts[1],'success');--}%
        %{--                    setTimeout(function () {--}%
        %{--                        location.href="${createLink(controller: 'proceso', action: 'comprobante')}?proceso=" + '${comprobante?.proceso?.id}';--}%
        %{--                        cargarComprobanteP('${comprobante?.proceso?.id}');--}%
        %{--                        cargarAsiento('${comprobante?.id}');--}%
        %{--                        cargarBotones('${comprobante?.id}');--}%
        %{--                    }, 800);--}%

        %{--                }else{--}%
        %{--                    closeLoader();--}%
        %{--                    log(parts[1],'error');--}%
        %{--                }--}%
        %{--            }--}%
        %{--        });--}%
        %{--    }--}%
        %{--})--}%
    });

</script>