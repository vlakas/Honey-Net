#!/bin/bash

kill $(ps -fux | grep plist | awk '{print $2}') 2>/dev/null
