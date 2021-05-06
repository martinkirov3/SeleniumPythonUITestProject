from selenium.webdriver.common.by import By

class SearchFilterElement(object):
    #BodyStyle = (By.XPATH, 'searchFiltersHeader', 'button')
    bodystyle = (By.CSS_SELECTOR, '.searchFiltersHeader > .button')
    
