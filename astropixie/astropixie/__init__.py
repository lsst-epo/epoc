import astropixie.catalog_service
import astropixie.mock_catalog_provider


def hello_universe():
    return "Hello universe!"


provider = astropixie.mock_catalog_provider.MockCatalogProvider()
Catalog = astropixie.catalog_service.CatalogService(provider)
