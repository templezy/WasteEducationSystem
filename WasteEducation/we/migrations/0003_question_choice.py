# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-22 00:20
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('we', '0002_auto_20151222_0012'),
    ]

    operations = [
        migrations.AddField(
            model_name='question',
            name='choice',
            field=models.CharField(choices=[('A', 'This is A'), ('B', 'This is B'), ('C', 'This is C'), ('D', 'This is D')], default=1, max_length=1),
            preserve_default=False,
        ),
    ]