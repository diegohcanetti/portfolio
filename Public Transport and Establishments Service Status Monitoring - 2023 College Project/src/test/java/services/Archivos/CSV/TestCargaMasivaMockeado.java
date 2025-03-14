package services.Archivos.CSV;

import models.Config.Config;
import models.domain.Entidades.Entidad;
import models.domain.Entidades.EntidadPrestadora;
import models.domain.Entidades.Establecimiento;
import models.domain.Entidades.OrganismoDeControl;
import models.domain.Servicios.Servicio;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import models.services.APIs.Georef.AdapterServicioGeo;
import models.services.Archivos.CargadorDeDatos;
import models.services.Archivos.SistemaDeArchivos;
import models.services.Localizacion.Municipio;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class TestCargaMasivaMockeado {
  static CargadorDeDatos cargadorDeDatos = new CargadorDeDatos();
  static SistemaDeArchivos sistemaDeArchivos = new SistemaDeArchivos();
  static List<OrganismoDeControl> empresas = new ArrayList<>();
  @Mock
  static AdapterServicioGeo servicioGeo;

  @BeforeAll
  public static void init2(){
    servicioGeo = mock(AdapterServicioGeo.class);
    String municipio = "Yavi";
    Municipio municipioMockeado = new Municipio();
    municipioMockeado.setId(386273);
    municipioMockeado.setNombre("Yavi");
    when(servicioGeo.obtenerMunicipio(municipio)).thenReturn(municipioMockeado);
    empresas = cargadorDeDatos.cargaDeDatosMASIVA(sistemaDeArchivos.csvALista(Config.ARCHIVO_CSV), servicioGeo);
  }

  @Test
  public void testServicios(){
    List<Servicio> servicios = empresas.get(0).getEntidadesPrestadoras().get(0).getEntidades().get(0).getEstablecimientos().get(0).getServicios();
    Assertions.assertEquals("Banio UNISEX", servicios.get(0).getTipo());
  }


  @Test
  public void testEstablecimientos(){
    List<Establecimiento> establecimientos = empresas.get(0).getEntidadesPrestadoras().get(0).getEntidades().get(0).getEstablecimientos();

    Assertions.assertEquals("Retiro", establecimientos.get(0).getNombre());
  }

  @Test
  public void testEntidades(){
    List<Entidad> entidades = empresas.get(0).getEntidadesPrestadoras().get(0).getEntidades();

    Assertions.assertEquals("Linea Roca", entidades.get(1).getNombre());
  }

  @Test
  public void testEntidadesPrestadoras(){
    List<EntidadPrestadora> prestadoras = empresas.get(0).getEntidadesPrestadoras();

    Assertions.assertEquals("Trenes Argentinos", prestadoras.get(0).getNombre());
  }

  @Test
  public void testOrganismosDeControl(){

    Assertions.assertEquals("CNRT", empresas.get(0).getNombre());
  }

  @Test  //ver si se modifican las entidades dentro una entidad prestadora ya registrada
  public void modificarEmpresaYaExistente(){
    List<Entidad> entidades;
    entidades = empresas.get(0).getEntidadesPrestadoras().get(0).getEntidades();

    Assertions.assertEquals("Linea Mitre",entidades.get(0).getNombre());
    Assertions.assertEquals("Linea Roca",entidades.get(1).getNombre());
  }
}