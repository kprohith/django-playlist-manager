# Generated by Django 3.0.8 on 2020-07-14 10:47

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0004_auto_20200714_1613'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='playlist',
            name='count',
        ),
        migrations.RemoveField(
            model_name='playlist',
            name='duration',
        ),
        migrations.RemoveField(
            model_name='song',
            name='duration',
        ),
        migrations.RemoveField(
            model_name='song',
            name='year',
        ),
    ]
