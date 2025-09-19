<div class="row">
    <div class="col-md-11 breadcrumb">
        <label class="col-md-12" style="font-size: 20px">3.- Datos de la Factura</label>
        <div class="col-md-3 tamano bd">
            RUC:
        </div>

        <div class="col-md-8 tamano ">
            ${empresa?.ruc}
        </div>
        <div class="col-md-3 tamano bd">
            Ambiente
        </div>

        <div class="col-md-8 tamano">
            ${empresa?.ambiente == '1' ? 'PRUEBAS' : 'PRODUCCIÓN'}
        </div>

    </div>
    <div class="btn-group col-md-1">
        <a href="#" class="btn btn-sm btn-success btnEditarDatosFactura" data-id="${empresa.id}" title="Editar información factura">
            <i class="fas fa-edit"></i> Editar
        </a>
    </div>
</div>

