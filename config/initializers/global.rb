# User possible roles
REGULAR_USER = 'user'
ADMIN = 'admin'
QA = 'qa'
DEVICE_ANDROID = 'android'
DEVICE_IOS = 'ios'
DEVICE_WEB = 'web'

# Whitelist of orderable fields
USER_ORDERABLE_FIELDS = %w(id first_name last_name email role created_at)

# Error messages declaration, used to prevent differences between API documentation
# and real messages returened in Object instance and generalize error messages output altogether
USER_ERROR_MESSAGES = {
    first_name: {
        presence: 'First name should be present'
    },
    last_name: {
        presence: 'Last name should be present'
    },
    email: {
        presence: "Email can't be blank",
        uniqueness: "User with this email already exists",
    },
    password: {
        presence: "Invalid password"
    },
    referral_code: {
        validity: "Invalid referral code"
    }
}

BASE_ERRORS = {
    invalid_token: 'Invalid token', # code 401
    invalid_password: 'Invalid password', # code 401
    no_resourse: 'No resourse found', # code 404
    invalid_credentials: 'Invalid email or password', # code 107
    internal_error: 'Something went wrong', # code 500
    user_blocked: 'Sorry, your user has been blocked',
    no_edit_permissions: "Owner of this rest-token can't edit resource with such ID"
}

RESPONSE_CODES = {
    100 => 'Continue',
    101 => 'Switching Protocols',
    102 => 'Processing',
    104 => "Email can't be blank and/or this email has already been taken",
    105 => 'Invalid password',
    107 => 'Invalid email or password',
    111 => 'Invalid referral code',
    200 => 'OK',
    201 => 'Created',
    202 => 'Accepted',
    203 => 'Non-Authoritative Information',
    204 => 'No Content',
    205 => 'Reset Content',
    206 => 'Partial Content',
    207 => 'Multi-Status',
    208 => 'Already Reported',
    226 => 'IM Used',
    300 => 'Multiple Choices',
    301 => 'Moved Permanently',
    302 => 'Found',
    303 => 'See Other',
    304 => 'Not Modified',
    305 => 'Use Proxy',
    307 => 'Temporary Redirect',
    308 => 'Permanent Redirect',
    400 => 'Bad Request',
    401 => 'Unauthorized',
    402 => 'Payment Required',
    403 => 'Forbidden',
    404 => 'Not Found',
    405 => 'Method Not Allowed',
    406 => 'Not Acceptable',
    407 => 'Proxy Authentication Required',
    408 => 'Request Timeout',
    409 => 'Conflict',
    410 => 'Gone',
    411 => 'Length Required',
    412 => 'Precondition Failed',
    413 => 'Payload Too Large',
    414 => 'URI Too Long',
    415 => 'Unsupported Media Type',
    416 => 'Range Not Satisfiable',
    417 => 'Expectation Failed',
    421 => 'Misdirected Request',
    422 => 'Unprocessable Entity',
    423 => 'Locked',
    424 => 'Failed Dependency',
    426 => 'Upgrade Required',
    428 => 'Precondition Required',
    429 => 'Too Many Requests',
    431 => 'Request Header Fields Too Large',
    460 => 'Country can not be blank or does not exist',
    461 => "State can not be blank or doesn't belong to selected country",
    462 => 'Address string can not be blank',
    463 => 'City can not be blank or is invalid',
    464 => 'Zip code can not be blank or is invalid',
    465 => 'Telephone number can not be blank or is invalid',
    470 => 'Error while retrieving Braintree customer',
    481 => 'Credit card must be present in order',
    482 => 'Shipping address must be present in order',
    483 => 'One or more items in order are not available for purchase',
    484 => 'Checkout was performed',
    500 => 'Internal Server Error',
    501 => 'Not Implemented',
    502 => 'Bad Gateway',
    503 => 'Service Unavailable',
    504 => 'Gateway Timeout',
    505 => 'HTTP Version Not Supported',
    506 => 'Variant Also Negotiates',
    507 => 'Insufficient Storage',
    508 => 'Loop Detected',
    510 => 'Not Extended',
    511 => 'Network Authentication Required'
}