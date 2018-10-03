### Proposal
While examining the code, I was thinking of ways to test it. I found the code difficult to test. I would like to propose a new structure as you can see in this machines folder.

1. There is a playbook for each type of *server*.
2. Different type of servers can then have variables in vars folder.
3. We can then test individual server types. To test NFS I can do `ansible-playbook nfs.yml` and to test NFS clients I can do `ansible-playbook webserver.yml`

We can also,
```yaml
  vars:
    ws_instances:
      - ws01
      - ws02
    instance_group: ws

  vars_files:
    - vars/all.yml

  tasks:
    - name: Create webserver(s)
      include_tasks: tasks/gce_create_instance.yml
      vars:
        instance_name: "{{ item }}"
      with_items:
        - "{{ ws_instances }}"
```

What do you guys think?