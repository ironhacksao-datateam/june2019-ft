# -*- coding: utf-8 -*-
import scrapy


class InovatecSpider(scrapy.Spider):
    name = 'inovaTec'
    allowed_domains = ['https://www.inovacaotecnologica.com.br/noticias/meta.php?meta=Baterias&base=']
    url = 'https://www.inovacaotecnologica.com.br/noticias/meta.php?meta=Baterias&base='
    start_urls = [url+str(i) for i in range(0, 150, 15)]

    def parse(self, response):
        inova = response.css()
        for i in inova:
            title = inova.css().extract_first()
            

