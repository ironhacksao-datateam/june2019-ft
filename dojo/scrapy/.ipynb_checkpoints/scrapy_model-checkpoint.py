# -*- coding: utf-8 -*-
import scrapy


class QuotesSpiderSpider(scrapy.Spider):
    name = 'quotes_spider'
    allowed_domains = ['http://quotes.toscrape.com']
    start_urls = ['http://http://quotes.toscrape.com/']

    def parse(self, response):
        pass
