<div >
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <g:if test="${extension == 'pdf'}">
            <embed src="${createLink(controller: 'historial', action: 'downloadFile', id: examen?.id)}" style="width: 100%; height: 600px" type='application/pdf'>
        </g:if>
        <g:else>
            <img src="${createLink(controller: 'historial', action: 'getImageExamen', params: [id:examen?.id] )}" class="imag_pq" style="margin-top: 10px; width: 300px; height: 300px"/>
        </g:else>
    </fieldset>
</div>