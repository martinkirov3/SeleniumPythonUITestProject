'''
Created on 3 May 2021

@author: Martin
'''
import unittest
#import PageObjectModl.page
#import PageObjectModel
from selenium import webdriver
import PageObjectModel
from PageObjectModel import highlight, page

#driver = webdriver.Chrome()

class Test(unittest.TestCase):


    def setUp(self):
        self.driver = webdriver.Chrome()
        self.driver.get("https://paulcamper.com/rent-camper/")


    def tearDown(self):
        self.driver.close()


    def test_bodystyle(self):
        ##self.click()
        bodystyle = PageObjectModel.locators.SearchFilterElement.bodystyle
        highlight(bodystyle)
        #a = bodystyle.count('Body style')
        #assertLess(a,3)
        page.MainPage.click_go_button(bodystyle)
        #bodystyle.assertTrue('Body style')
        


if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()