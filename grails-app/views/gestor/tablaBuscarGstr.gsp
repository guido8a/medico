<util:renderHTML html="${msg}"/>

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

<g:set var="clase" value="${'principal'}"/>

<div class="" style="width: 99.7%;height: ${msg == '' ? 410 : 395}px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover table-striped" style="width: 100%">
        <g:each in="${data}" var="dato" status="z">
            <tr id="${dato.gstr__id}" data-id="${dato.gstr__id}" data-ed="${dato.gstretdo}" class="${clase}" style="font-size: 14px">
                <td style="width: 20%">
                    ${dato?.tppsdscr}
                </td>
                <td style="width: 50%" class="text-success">
                    ${dato?.gstrnmbr}
                </td>
                <td style="width: 15%">
                    ${dato.gstretdo == 'R' ? 'Registrado' : 'No registrado'}
                </td>
                <td style="width: 15%" class="text-info">
                    ${dato.tipo}
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });
    });
</script>
