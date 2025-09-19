<div class="row">
    <div class="col-md-11 breadcrumb">
        <label class="col-md-12" style="font-size: 20px">1.- Datos de la Empresa</label>
        <div class="col-md-3 tamano bd">
            Nombre:
        </div>

        <div class="col-md-8 tamano ">
            ${empresa?.nombre}
        </div>
        <div class="col-md-3 tamano bd">
            Dirección:
        </div>

        <div class="col-md-8 tamano">
            ${empresa?.direccion}
        </div>
        <div class="col-md-3 tamano bd">
            Contribuyente especial:
        </div>

        <div class="col-md-8 tamano">
            ${empresa?.contribuyenteEspecial == 'N' ? 'NO' : 'SI'}
        </div>

        <div class="col-md-3 tamano bd">
            Obligado a llevar contabilidad:
        </div>

        <div class="col-md-8 tamano">
            ${empresa?.obligadaContabilidad == '0' ? 'NO' : 'SI'}
        </div>
    </div>
    <div class="btn-group col-md-1">
        <a href="#" class="btn btn-sm btn-success btnEditarEmpresa" data-id="${empresa.id}" title="Editar empresa">
            <i class="fas fa-edit"></i> Editar
        </a>
    </div>
</div>