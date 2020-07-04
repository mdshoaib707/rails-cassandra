#!/bin/bash

rails cequel:keyspace:create_if_not_exist
rails cequel:migrate
rails s --binding=0.0.0.0 --port=3000