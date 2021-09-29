# Little Esty Shop

<p align="center">
  <img src="https://user-images.githubusercontent.com/78242081/134249617-009366df-7ec0-4330-91ec-48809562c526.png" alt="little_etsy_shop_db_schema"/>
</p>

## Table of Contents

- [Overview](#overview)
- [Tools Utilized](#framework)
- [Setup](#setup)
- [Contributors](#contributors)


# README

### <ins>Overview</ins>

[Little Esty Shop](https://github.com/hschmid516/little-esty-shop) is a 10-day, 4 person project, during Module 2 of 4 for Turing School's Back End Engineering Program.

Our challenge was to build a functioning web app consisting of multiple relational databases to model the popular e-commerce web site *Etsy*.

Little Esty Shop allowed us to apply priniciples of flow control across multiple methods, design one-to-many relationships using [DB Designer](https://www.dbdesigner.net/), and write migrations to create tables with columns of varying data types and foreign keys. Ruby on Rails helped give us a framework to create instance and class methods on a Rails model that uses ActiveRecord methods and helpers, letting our users experience CRUD functionality through our application. By maintaining a TDD mindset, we were able to make sure our features and models were being test consitently throughout the development process.

This project includes a "Bulk Discounts" extension that was built individually as the final project for Module 2 at Turing. Functionality was added to create bulk discounts for items, with an emphasis on TDD and MVC.

[Technical Requirements](https://github.com/turingschool-examples/little-esty-shop/blob/main/doc/user_stories.md)
[Bulk Discount Individual Extention Requirements](https://backend.turing.edu/module2/projects/bulk_discounts)

#### Framework
<p>
  <img src="https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white" />
</p>

#### Languages
<p>
  <img src="https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white" />
  <img src="https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white" />
  <img src="https://img.shields.io/badge/HTML5-0EB201.svg?&style=flaste&logo=html5&logoColor=white" />
  <img src="https://img.shields.io/badge/CSS3-1572B6.svg?&style=flaste&logo=css3&logoColor=white" />
</p>

#### Tools
<p>
  <img src="https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white" />
  <img src="https://img.shields.io/badge/VS_Code-007ACC?logo=visual%20studio%20code&logoColor=ffffff" />
  <img src="https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white" />
  <img src="https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white" />
</p>

#### Gems
<p>
  <img src="https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/faker-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" /> </br>
  <img src="https://img.shields.io/badge/launchy-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />  
  <img src="https://img.shields.io/badge/capybara-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/orderly-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/faraday-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/bcrypt-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
  <img src="https://img.shields.io/badge/factory--bot-b81818.svg?&style=flaste&logo=rubygems&logoColor=white" />
</p>

#### Development Principles
<p>
  <img src="https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white" />
  <img src="https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white" />
  <img src="https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white" />
  <img src="https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white" />  
</p>

### <ins>Setup</ins>

* Ruby version
    ```bash
    $ ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
    ```

* [System dependencies](https://github.com/hschmid516/little-esty-shop/blob/main/Gemfile)
    ```bash
    $ rails -v
    Rails 5.2.6
    ```

* Database creation
    ```bash
    $ rails db:{drop,create,migrate}
    Created database 'little_esty_shop_development'
    Created database 'little_esty_shop_test'
    ```

* Database initialization
    ```bash
    $ rake csv_load:all
    ```

* How to run the test suite
    ```bash
    $ bundle exec rspec -fd
    ```

* [Local Deployment](http://localhost:3000), for testing:
    ```bash
    $ rails s
    => Booting Puma
    => Rails 5.2.6 application starting in development
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.12.6 (ruby 2.7.2-p137), codename: Llamas in Pajamas
    * Min threads: 5, max threads: 5
    * Environment: development
    * Listening on tcp://localhost:3000
    Use Ctrl-C to stop

    ```
* [Heroku Deployment](https://floating-earth-36791.herokuapp.com/), for production

### <ins>Contributors</ins>
<p>
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
</p>

- [Henry Schmid](https://www.linkedin.com/in/henry-schmid)
- [Andrew Massey](https://www.linkedin.com/in/andrew-massey-b06662194/)
- [Kevin Mugele](https://www.linkedin.com/in/kevinmugele/)
- [Khoi Nguyen](https://www.linkedin.com/in/khoifishpond/)

<p>
  <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />
</p>

- [Henry Schmid](https://github.com/hschmid516)
- [Andrew Massey](https://github.com/acmassey3698)
- [Kevin Mugele](https://github.com/kevinmugele)
- [Khoi Nguyen](https://github.com/khoifishpond)
