1. Pull the Official PostgreSQL Image;
You can find the official image on Docker Hub. To deploy a specific version (e.g., PostgreSQL 13), follow the steps below.

2. Run the PostgreSQL Container;
Execute the following command to spin up the PostgreSQL container with persistent volume storage and custom port mapping:

docker run -d \
    --name postgresql \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=Ankara06 \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -p 5433:5432 \
    -v postgresql13_v:/var/lib/postgresql/data \
    postgres:13

    Note: Port 5433 on the host is mapped to the default PostgreSQL port 5432 inside the container to avoid conflicts with any local PostgreSQL instances.
    
3. Verify the Container Status
Check if the container is up and running properly:
docker ps

Expected Output:
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                       NAMES
abdeec35557e   postgres:13   "docker-entrypoint.s…"   6 seconds ago   Up 5 seconds   0.0.0.0:5433->5432/tcp, :::5433->5432/tcp   postgresql

Database Configuration;
4.Access the Container via Interactive Terminal (psql)
Connect to the PostgreSQL instance inside the running container using psql:
docker exec -it postgresql psql -d postgres -U postgres

5.Create Database, User, and Grant Privileges
Once inside the psql shell, execute the following SQL commands to set up a new database environment:
-- Create a new database
CREATE DATABASE traindb;

-- Create a new user with a secure password
CREATE USER train WITH ENCRYPTED PASSWORD 'Ankara06';

-- Grant all privileges on the new database to the user
GRANT ALL PRIVILEGES ON DATABASE traindb TO train;


Remote Access & Client Connection
6. Port Forwarding (For VirtualBox Users)
If your Docker environment is running inside a VirtualBox Guest VM, you need to expose the port to your Host machine:

Open VirtualBox and go to Settings -> Network -> Advanced -> Port Forwarding.

Add a new rule:

Host Port: 5433

Guest Port: 5433

7. Connect via DBeaver
Open DBeaver on your host machine.

Click on New Database Connection and select PostgreSQL.

Configure the connection settings:

Host: localhost (or your VM's IP address)

Port: 5433

Database: traindb

Username: train

Password: Ankara06

Click Test Connection to verify, then click Finish.
