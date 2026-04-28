# Vehicle Insurance App Locators

# Main Navigation
NAV_AUTOMOBILE = 'div.main-navigation >> "Automobile"'

# Vehicle Data
MAKE_DROPDOWN = 'id=make'
ENGINE_PERFORMANCE_INPUT = 'id=engineperformance'
DATE_OF_MANUFACTURE_INPUT = 'id=dateofmanufacture'
NUMBER_OF_SEATS_DROPDOWN = 'id=numberofseats'
FUEL_TYPE_DROPDOWN = 'id=fuel'
LIST_PRICE_INPUT = 'id=listprice'
LICENSE_PLATE_INPUT = 'id=licenseplatenumber'
ANNUAL_MILEAGE_INPUT = 'id=annualmileage'
NEXT_BUTTON = 'section[style="display: block;"] >> text=Next »'

# Insurant Data
FIRST_NAME_INPUT = 'id=firstname'
LAST_NAME_INPUT = 'id=lastname'
BIRTH_DATE_INPUT = 'id=birthdate'
GENDER_MALE_RADIO = '*css=label >> id=gendermale'
STREET_ADDRESS_INPUT = 'id=streetaddress'
COUNTRY_DROPDOWN = 'id=country'
ZIP_CODE_INPUT = 'id=zipcode'
CITY_INPUT = 'id=city'
OCCUPATION_DROPDOWN = 'id=occupation'
HOBBY_CLIFF_DIVING_CHECKBOX = 'text=Cliff Diving'

# Product Data
START_DATE_INPUT = 'id=startdate'
INSURANCE_SUM_DROPDOWN = 'id=insurancesum'
MERIT_RATING_DROPDOWN = 'id=meritrating'
DAMAGE_INSURANCE_DROPDOWN = 'id=damageinsurance'
EURO_PROTECTION_CHECKBOX = '*css=label >> id=EuroProtection'
COURTESY_CAR_DROPDOWN = 'id=courtesycar'

# Select Price Option
# Using Robot Framework's variable syntax inside the string so it interpolates when used in the robot file
PRICE_OPTION_RADIO = '*css=label >> css=[value=${price_option}]'

# Send Quote
EMAIL_INPUT = '"E-Mail" >> .. >> input'
PHONE_INPUT = '"Phone" >> .. >> input'
USERNAME_INPUT = '"Username" >> .. >> input'
PASSWORD_INPUT = '"Password" >> .. >> input'
CONFIRM_PASSWORD_INPUT = '"Confirm Password" >> .. >> input'
COMMENTS_TEXTAREA = '"Comments" >> .. >> textarea'
SEND_EMAIL_BUTTON = '"« Send »"'
SUCCESS_MESSAGE_TEXT = '"Sending e-mail success!"'
OK_BUTTON = '"OK"'
