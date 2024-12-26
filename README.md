# wordpressdemo

This is a demo of OpenShift for students at Lernia education.
Modified by Sei
Course DevOps Engineer 23/24

## The namespace

The namespace is set in `namespace.yaml` choose what you want and create it:

```sh
$ oc apply -f namespace.yaml
```

Then use the namespace:

```sh
$ oc project myNameSpace
```

## MariaDB

## WordPress

You need to create the PVC, and then mount it as /data. Start the Wordpress pod and copy files from /opt/app-root/src/ to /data. Change the `mountPath` in `wordpress-deployment.yaml` to `/data`:

```yaml
        volumeMounts:
        - name: wordpress-data
          mountPath: /data
```

Delete the deployment and restart it:

```sh
$ oc delete deployment/wordpress
$ oc apply -f wordpress-deployment.yaml
```

Now find the name of the wordpress pod:

```sh
$ oc get pod
NAME                         READY   STATUS    RESTARTS   AGE
mariadb-77fdb58778-jwxp4     1/1     Running   0          61m
wordpress-764f45dbcf-6mqt8   1/1     Running   0          61m
```

In this example the pod is named `wordpress-764f45dbcf-6mqt8`, yours will be different!

Connect to the pod:

```sh
$ oc rsh pod/wordpress-764f45dbcf-6mqt8
```

In the pod you run:

```sh
$ cp -R /opt/app-root/src/* /data/
$ exit
```

Delete the wordpress pod and change Deployment configuration so it volume mounts the pvc in /opt/app-root/src/ folder instead.


```yaml
        volumeMounts:
        - name: wordpress-data
          mountPath: /opt/app-root/src
```

Apply the deployment:

```sh
$ oc apply -f wordpress-deployment.yaml
```



