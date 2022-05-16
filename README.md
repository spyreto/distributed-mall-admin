<div id="top"></div>
<!-- Distributed Mall admin inteface -->

[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/spyreto">
    <img src="logo.png" alt="Logo" width="250" height="200">
  </a>

  <h3 align="center">Distributed Mall Admin</h3>

  <p align="center">
    Retail Stores Commercial Alliance!
    <br />
    <a href="https://github.com/spyreto/distributed-mall-admin/issues">Report Bug</a>
    ·
    <a href="https://github.com/spyreto/distributed-mall-admin/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
    <summary>Table of Contents</summary>
    <ol>
        <li>
            <a href="#about-the-project">About Distributed Mall</a>
        </li>
        <li>
            <a href="#distributed-mall-admin">Distributed Mall Admin</a>
            <ul>
                <li><a href="#overview">Overview</a></li>
                <li><a href="#built-with">Built With</a></li>
            </ul>
        </li>
        <li>
            <a href="#getting-started">Getting Started</a>
            <ul>
                <li><a href="#requirements">Requirements</a></li>
                <li><a href="#installation">Installation</a></li>
            </ul>
        </li>
        <li><a href="#built-in-commands">Built-in Commands</a></li>
        <li><a href="#contributing">Contributing</a></li>
        <li><a href="#license">License</a></li>
        <li><a href="#contact">Contact</a></li>
    </ol>
</details>


<!-- ABOUT THE DISTRIBUTED MALL -->
## About Distributed Mall

Distributed Mall is a multi vendor eCommerce platform, which will allow independent retailers to enter into trade "alliances" in order to achieve economies of scale and the provision of innovative digital services, so as to make them competitive with shopping malls and e-commerce stores. Τhe platform consists of two subsystems:

* <a href="https://github.com/spyreto/distributed-mall-admin">distributed-mall-admin</a> &rarr; content management system for retailers  
* <a href="https://github.com/spyreto/distributed-mall-app">distributed-mall-app</a> &rarr; location based mobile application of the end users

<p align="right">(<a href="#top">back to top</a>)</p>


## Distributed Mall Admin

### Overview

Distributed Mall Admin is the interface of the sellers through which they can perform the following operations:

* Creating a seller account.
* Introducing a new product in the online catalog.
* Introducing a new product in the online repository.
* Product management.
* Product modification in the electronic repository.
* Τhe display of sales.
* Τhe display of statistics and graphs.

<p align="right">(<a href="#top">back to top</a>)</p>


### Built With

Main frameworks/libraries used to develop this project:

* [Django](https://www.djangoproject.com/)
* [Django REST framework](https://www.django-rest-framework.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [SB Admin Template](https://github.com/StartBootstrap/startbootstrap-sb-admin)
* [Bootstrap](https://getbootstrap.com)
* [JQuery](https://jquery.com)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- GETTING STARTED -->

## Getting Started

### Requirements

*  [Python 3.5](https://www.python.org/downloads/) or greater
*  [PostgreSQL](https://www.postgresql.org/download/)
*  [Pip](https://pypi.org/project/pip/)
*  [Node.js](https://nodejs.org/en/)
*  [Gulp](https://gulpjs.com/docs/en/getting-started/quick-start)

<p align="right">(<a href="#top">bacak to top</a>)</p>


### Installation

1. Clone the repo:
   ```sh
   git clone https://github.com/spyreto/distributed-mall-admin.git
   ```
   
2.	Enter inside the project:
    ```sh
    cd distributed-mall-admin
    ```

3.	Create `.env` file and add the following lines:
    ```sh
    DEBUG=True
    DATABASE_URL='postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]db?'
    # Example: DATABASE_URL=postgres://spyreto:1234@localhost:5432/distributed_mall_db?
    ALLOWED_HOSTS="localhost 192.168.2.10"
    # Example: ALLOWED_HOSTS="localhost 192.168.2.10"
    SECRET_KEY= 'youSecretKey'
    GOOGLE_MAPS_API_KEY='youGoogleMapsApiKey'
    ```

4.	Setup `psql` database.

5.  Create a python virtual environment within the project directory and activate it.

6.  Install the required `python packages`:
    ```sh
    pip install -r requirements.txt
    ```
7.  Install the required `node packages`:
    ```sh
    npm i
    ```    

8. Create `static files` using Gulp: 
    ```sh
    gulp build
    ```   
9.  It's time to migrate the initial database schema to the project's psql database using the management script:
    ```sh
    py manage.py makemigrations
    py manage.py migrate
    ```  
10. Create the `admin user` for the project:

11. Finally, you can run the Distributed Mall vendor interface by typing:
    ```sh
    py manage.py runserver 0.0.0.0:8000
    ``` 

<p align="right">(<a href="#top">back to top</a>)</p>

## Built-in Commands

The following commands have been created, which were considered necessary during the development of the platform.

*   Import products categories:
    ```sh
    py manage.py import_products_categories "path-to-csv-file"
    ```
    
*   Import companies categories (etc clothes shop):
    ```sh
     py manage.py import_companies_categories"path-to-csv-file"
    ```    

*   Import products from the following categories &rarr; clothing_products | footwear_products | bags | wallets | watches :
    ```sh
    py manage.py import_["product-category"]_categories "path-to-csv-file"
    # Example: py manage.py import_products_categories samples/products-categories.csv
    ``` 
    
*   Close inactive offers or activates valid offers
    ```sh
    py manage.py update_offers
    ``` 

*   Remove_inactive_manufacturers and shop a list of them  `-l flag`
    ```sh
    py manage.py remove_inactive_manufacturers -l
    ```
    
<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request.
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the Apache License 2.0. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Dimos - Spiridon Dimou - [Linkedin](https://www.linkedin.com/in/spiridon-dimou-2aa98216b) - spirosdimou2@hotmail.gr

Project Link: [Distributed Mall Admin](https://github.com/spyreto/distributed-mall-admin)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[issues-shield]:https://img.shields.io/github/issues/spyreto/distributed-mall-admin?style=flat-square
[issues-url]: https://github.com/spyreto/distributed-mall-admin/issues
[license-shield]: https://img.shields.io/github/license/spyreto/distributed-mall-admin?style=flat-square
[license-url]: https://github.com/spyreto/distributed-mall-admin/blob/main/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/spiridon-dimou-2aa98216b/
