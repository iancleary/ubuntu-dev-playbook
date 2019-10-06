deploy-website-s3
=========

This role deploys the website to my S3 bucket.

Requirements
------------

- awscli
  - IAM user with `S3FullAccess` permissions (create one in the console if needed)
     - I named my user 'ansible_s3'
  - setup `awscli` locally with `aws configure` using the credentials and region of your s3 bucket

Role Variables
--------------

defaults/main.yml
 - website_root_dir: absolute path to the folder you want to deploy to s3
 - bucket_name: name of s3 bucket

Dependencies
------------
 There are no dependencies on other roles.


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - name: upload website to S3
      hosts: localhost
      remote_user: root
      roles:
        - { role: deploy-website-s3, tags: [ 'deploy-website-s3' ] 

License
-------

BSD

Author Information
------------------

Ian Cleary, with help from: 
- [ansible localhost command](https://gist.github.com/alces/caa3e7e5f46f9595f715f0f55eef65c1)
- [ansible playbook](https://github.com/dmitri-lerko/ansible-jekyll)
