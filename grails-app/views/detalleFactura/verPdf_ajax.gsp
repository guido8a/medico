<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <embed src="${createLink(controller: 'reportes3', action: '_facturaElectronicaPdf', params:[id: proceso?.id, emp: empresa?.id])}" style="width: 100%; height: 600px" type='application/pdf'>
    </fieldset>
</div>
