To instrument this application, we will make use of the prometheus-client python library. Install the same by running the following command on prometheus-server:


pip install prometheus-client


# Update the /root/main.py file to replace the Question 3: PLACEHOLDER section with a Counter metric called http_requests_total. Find more details below:



   (a) First, import the Counter object from the prometheus-client library


from prometheus_client import Counter
   (b) Create a Counter object and name it REQUESTS


         (i) Metric name should be: http_requests_total


         (ii) Description should be: Total number of requests


REQUESTS = Counter('http_requests_total',
                   'Total number of requests')

# solution

Edit /root/main.py file:


vi /root/main.py



Update from prometheus_client line to import Counter:


from prometheus_client import Counter



Replace Question 3: PLACEHOLDER section with below lines:


REQUESTS = Counter('http_requests_total',
                   'Total number of requests')



Update the /root/main.py file to replace the Question 4: PLACEHOLDER[1-4] sections with the required code blocks.


The http_requests_total metric will track the total number of requests received by the application. This metric should be incremental in all 4 API endpoints defined in /root/main.py. The code that needs to be added is:

REQUESTS.inc()

# sol

Edit /root/main.py file:


vi /root/main.py



Replace each Question 4: PLACEHOLDER[1-4] section with below line:


    REQUESTS.inc()



The updated section of the file will look like as below:


@app.get("/products")
def get_products():
    REQUESTS.inc()
    return "product"


@app.post("/products")
def create_product():
    REQUESTS.inc()
    return "created product", 201


@app.get("/cart")
def get_cart():
    REQUESTS.inc()
    return "cart"


@app.post("/cart")
def create_cart():
    REQUESTS.inc()
    return "created cart", 201