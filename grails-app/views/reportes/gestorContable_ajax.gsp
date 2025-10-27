<%@ page import="sri.Contabilidad" %>
<div class="row">
    <div class="col-md-12">
        <div class="col-md-2" style="font-weight: bold">
            Contabilidad
        </div>
        <div class="col-md-9">
            <g:select name="contCuentas" id="contCuentas" from="${sri.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                      optionKey="id" optionValue="descripcion" class="form-control"/>
        </div>
    </div>
</div>